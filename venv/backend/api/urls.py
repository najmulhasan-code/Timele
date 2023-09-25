from django.urls import path
from .views import ParagraphRetriveUpdateDestroyView, ParagraphGetCreate

urlpatterns = [
    path('', ParagraphGetCreate.as_view()),
    path('<int:pk>/', ParagraphRetriveUpdateDestroyView.as_view(), name = 'paragraph'),


]
