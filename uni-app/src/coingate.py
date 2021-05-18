import requests
import json


def get_rate(source, quote):
    return requests.get(f'https://api.coingate.com/v2/rates/merchant/{source}/{quote}').content.decode('UTF-8')


def get_currency_list():
    currency_list = []
    json_obj = json.loads(requests.get(f'https://api.coingate.com/v2/currencies').content.decode('UTF-8'))
    for currency_json in json_obj:
        if currency_json["native"]:
            currency_list.append(f"{currency_json['symbol']}")
    currency_list.sort()
    return currency_list
