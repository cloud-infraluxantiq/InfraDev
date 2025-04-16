
# firebase_auth.py
# -----------------
# This Django middleware validates Firebase ID tokens from Authorization headers.
# If valid, it attaches `firebase_user` to the request object.

import firebase_admin
from firebase_admin import auth, credentials
from django.http import JsonResponse
from django.utils.deprecation import MiddlewareMixin

# Initialize Firebase Admin SDK only once (singleton pattern)
if not firebase_admin._apps:
    cred = credentials.ApplicationDefault()  # Uses GOOGLE_APPLICATION_CREDENTIALS env var
    firebase_admin.initialize_app(cred)

class FirebaseAuthMiddleware(MiddlewareMixin):
    def process_request(self, request):
        id_token = None

        # Extract token from Authorization: Bearer <token>
        auth_header = request.META.get('HTTP_AUTHORIZATION')
        if auth_header and auth_header.startswith('Bearer '):
            id_token = auth_header.split('Bearer ')[1]

        if id_token:
            try:
                # Verify token with Firebase
                decoded_token = auth.verify_id_token(id_token)
                request.firebase_user = decoded_token  # Attach to request
            except Exception as e:
                # Token is invalid or expired — return 401
                return JsonResponse({
                    'error': 'Invalid or expired token',
                    'detail': str(e)
                }, status=401)
        else:
            # No token found — mark request as anonymous
            request.firebase_user = None


#MIDDLEWARE = [
  #  ...
 #   'your_app.middleware.firebase_auth.FirebaseAuthMiddleware',
 #   ...
#]
