from .serializers import ParagraphSerializer
from rest_framework import generics
from .models import Paragraph

# Create your views here.
class ParagraphGetCreate(generics.ListCreateAPIView):
    queryset = Paragraph.objects.all()
    serializer_class = ParagraphSerializer

class ParagraphRetriveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Paragraph.objects.all()
    serializer_class = ParagraphSerializer



