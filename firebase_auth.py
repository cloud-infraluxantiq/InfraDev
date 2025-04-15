
# firebase_auth.py

import firebase_admin
from firebase_admin import auth, credentials
from django.http import JsonResponse
from django.utils.deprecation import MiddlewareMixin

if not firebase_admin._apps:
    cred = credentials.ApplicationDefault()
    firebase_admin.initialize_app(cred)

class FirebaseAuthMiddleware(MiddlewareMixin):
    def process_request(self, request):
        id_token = None
        auth_header = request.META.get('HTTP_AUTHORIZATION')

        if auth_header and auth_header.startswith('Bearer '):
            id_token = auth_header.split('Bearer ')[1]

        if id_token:
            try:
                decoded_token = auth.verify_id_token(id_token)
                request.firebase_user = decoded_token
            except Exception as e:
                return JsonResponse({'error': 'Invalid or expired token', 'detail': str(e)}, status=401)
        else:
            request.firebase_user = None
