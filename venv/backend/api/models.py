from django.db import models

# Create your models here.


class Paragraph(models.Model):
    title = models.CharField(max_length= 10)
    description = models.TextField(max_length= 4)

    def __str__(self):
        return self.title

