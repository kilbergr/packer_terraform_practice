from django.http import HttpResponse
import requests


def index(request):
    response = requests.get('http://169.254.169.254/latest/meta-data/instance-id')
    instance_id = response.text
    return HttpResponse(instance_id)