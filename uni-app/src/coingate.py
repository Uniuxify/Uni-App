import requests
import json


def get_rate(source, quote):
    return float(requests.get(f'https://api.coingate.com/v2/rates/merchant/{source}/{quote}').content.decode('UTF-8'))


def get_currency_list():
    currency_list = []
    json_obj = json.loads(requests.get(f'https://api.coingate.com/v2/currencies').content.decode('UTF-8'))
    for currency_json in json_obj:
        currency_list.append(f"{currency_json['title']} ({currency_json['symbol']})")
    return currency_list
