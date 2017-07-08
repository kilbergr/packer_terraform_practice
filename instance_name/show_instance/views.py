from django.http import HttpResponse
from random import randint
import requests

jokes = [
	"What did the monkey say when he caught his tail in the revolving door? It won't be long now", 
	"What's the best way to carve wood? Whittle by whittle",
	"What do you call a guy with a rubber toe? Roberto"
]


def index(request):
    response = requests.get('http://169.254.169.254/latest/meta-data/instance-id')
    instance_id = response.text
    randnum = randint(0, 2)
    return HttpResponse('ID {} JOKE {}'.format(instand_id, jokes[randnum]))
