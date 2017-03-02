# README


Проблемы
  * Не удаляются товары из корзины
  * css во вьюхах


Работа с API subtotal
  Авторизация
    curl -H "Content-Type: application/json" -X POST -d '{"login":"kereal@gmail.com","password":"12345"}' https://app.subtotal.ru/webapi/login
  Ответ
    {
      "status": 200,
      "last_owner": "id11542",
      "urls": {
        "ccm_pos_env": "https://app.subtotal.ru/%7B%2A%7D/dktapp/ccm/env/%7B%2A%2A%7D",
        "shop_list": "https://app.subtotal.ru/subtotal_common/dktapp/shop_list",
        "pos_list": "https://app.subtotal.ru/%7B%2A%7D/dktapp/common/pos_list",
        "egais_events": "https://app.subtotal.ru/subtotal_events/?owid=%7B%2A%2A%2A%7D",
        "ccm_pos_set": "https://app.subtotal.ru/%7B%2A%7D/dktapp/ccm/pos/%7B%2A%2A%7D",
        "egais_events_from_egais": "https://app.subtotal.ru/%7B%2A%7D/events/from_egais"
      }
    }

Товар в списке (/goods)
    {
      "ch_date": "2017-02-18 12:39:45.675058+01:00",
      "name": "Батник красный BGN жен",
      "unit_code": "шт.",
      "country": "Франция",
      "barcode": "21900430004278",
      "fdel": false,
      "good_type_id": "2",
      "producer_name": "Перово мальчики",
      "images": [
        "/id11542/good3566508_picviewimage1.php",
        "/id11542/good3566508_picviewimage2.php"
      ],
      "article": "187281",
      "price1": "",
      "price0": "1000.0",
      "price2": "6000.0",
      "id": "3566508",
      "status_ico": ""
    }
Товар отдельно (/goods/id)
{
  "units": [
    {
      "id": 48,
      "name": "граммы"
    },
    {
      "id": 62359,
      "name": "декалитры"
    },
    {
      "id": 11,
      "name": "квадратные метры"
    },
    {
      "id": 6,
      "name": "килограммы"
    },
    {
      "id": 54,
      "name": "километры"
    },
    {
      "id": 5,
      "name": "кубометры"
    },
    {
      "id": 2,
      "name": "литры"
    },
    {
      "id": 3,
      "name": "метры"
    },
    {
      "id": 12,
      "name": "упаковка"
    },
    {
      "id": 7,
      "name": "часы"
    },
    {
      "id": 1,
      "name": "штуки"
    }
  ],
  "egais_active": 0,
  "good": {
    "code": "",
    "weight": null,
    "variation_id": null,
    "image3": {
      "place": 0,
      "del": 0
    },
    "good_type_id": 2,
    "article": "187281",
    "id": 3566508,
    "unit": "штуки",
    "producer": {
      "id": 88100,
      "name": "Перово мальчики"
    },
    "is_base_for_variation": false,
    "country_id": 225,
    "unit_id": 1,
    "discounts": [
      {
        "is_wholesale": false,
        "is_retail": true,
        "discounts": [
          {
            "display_name": "",
            "name": "",
            "value": 70
          }
        ],
        "id": 5,
        "name": "Клиент (розница)"
      },
      {
        "is_wholesale": true,
        "is_retail": false,
        "discounts": [
          {
            "display_name": "",
            "name": "",
            "value": null
          }
        ],
        "id": 2,
        "name": "Клиент (опт)"
      }
    ],
    "description": "",
    "running_out_number": null,
    "tags": [
      "BGN"
    ],
    "barcode": "21900430004278",
    "producer_id": 88100,
    "volume": null,
    "prices": [
      {
        "price_id": 35072,
        "code": "Цена",
        "name": "Цена продажи",
        "item_id": 8554860,
        "is_required": true,
        "is_min": false,
        "value": 6000,
        "is_cost": false
      },
      {
        "price_id": 35071,
        "code": "Мин.Цена",
        "name": "Минимальная цена продажи",
        "item_id": 8554861,
        "is_required": false,
        "is_min": true,
        "value": null,
        "is_cost": false
      },
      {
        "price_id": 35070,
        "code": "Зак.Цена",
        "name": "Закупочная цена",
        "item_id": 8554862,
        "is_required": false,
        "is_min": false,
        "value": 1000,
        "is_cost": true
      }
    ],
    "image2": {
      "url": "https://app.subtotal.ru/id11542/good3566508_picviewimage2.php",
      "place": 1,
      "del": 0
    },
    "image1": {
      "url": "https://app.subtotal.ru/id11542/good3566508_picviewimage1.php",
      "place": 1,
      "del": 0
    },
    "properties": [
      {
        "values": [
          {
            "pv_id": 24539,
            "value": "Блузы и рубашки"
          }
        ],
        "id": 20862,
        "name": "Категория товара"
      },
      {
        "values": [
          {
            "pv_id": 24538,
            "value": "жен"
          }
        ],
        "id": 20861,
        "name": "Пол"
      },
      {
        "values": [
          {
            "pv_id": 24537,
            "value": "48"
          }
        ],
        "id": 19122,
        "name": "Размер"
      },
      {
        "values": [
          {
            "pv_id": 24540,
            "value": "91% вискоза, 9% шерсть"
          }
        ],
        "id": 20863,
        "name": "Состав"
      }
    ],
    "image4": {
      "place": 0,
      "del": 0
    },
    "name": "Батник красный BGN жен",
    "country": "Франция",
    "running_out_type": null,
    "nds": null
  },
  "properties": [
    {
      "id": 20862,
      "name": "Категория товара"
    },
    {
      "id": 20861,
      "name": "Пол"
    },
    {
      "id": 19122,
      "name": "Размер"
    },
    {
      "id": 20863,
      "name": "Состав"
    },
    {
      "id": 19123,
      "name": "Цвет"
    }
  ],
  "tags": [
    "BGN",
    "BLUBIANCO",
    "COP.COPINE",
    "Eight2Nine",
    "ETINCELLE",
    "Jack Jons",
    "Jacky&Celine",
    "MADELEINE",
    "marville",
    "RICHMOND",
    "RinasCimento",
    "SCOTCH & SODA",
    "Takeshy Kurosava",
    "ZAPA",
    "Брюки жен"
  ]
}


response = RestClient.post('https://app.subtotal.ru/webapi/login', {"login":"kereal@gmail.com","password":"12345"}.to_json, { content_type: 'application/json; charset=utf-8' })
cookies = response.cookies
response = RestClient.get('https://app.subtotal.ru/id11542/webapi/goods', { cookies: cookies, good_type_id: 2, content_type: 'application/json; charset=utf-8' })

https://app.subtotal.ru/id11542/good3678147_picviewimage1.php
