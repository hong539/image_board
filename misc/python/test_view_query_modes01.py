from django.views.generic import DetailView
from app.models import Model1, Model2

class MyDetailView(DetailView):
    model = Model1
    template_name = 'my_template.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['model2'] = Model2.objects.all()
        return context