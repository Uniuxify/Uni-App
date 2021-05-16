import requests


def get_rate(source, quote):
    return float(requests.get(f'https://api.coingate.com/v2/rates/merchant/{source}/{quote}').content.decode('UTF-8'))
