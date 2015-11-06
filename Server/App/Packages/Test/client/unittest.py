#!/usr/bin/env python
# -*- coding: utf-8 -*- 

# ============================================================================
#    File: unittest.py
#
#    Desc: Null 
#
# Version: 1.0
#    Date: 2015-09-20 17:53:56
#  Author: huabo (daijun), caodaijun@baidu.com
# Company: baidu.com
#
#                          --- Copyleft (c), 2015 ---
#                              All Rights Reserved.
# ============================================================================


import json
import urllib
import pycurl
import cStringIO


HOST = "http://127.0.0.1"


def ProductCommentUnitTest():
    url = HOST + "/ProductComment"
    values = {
            "ProductId":  "1000",
            "Comment":    "评论内容",
            "ConsumerId": "100"
            }

    buf = cStringIO.StringIO()
    c = pycurl.Curl()
    c.setopt(pycurl.URL, url)
    c.setopt(pycurl.POST, 1)
    c.setopt(pycurl.POSTFIELDS, json.dumps(values))
    c.setopt(c.WRITEFUNCTION, buf.write)
    c.perform()

    httpCode = c.getinfo(c.HTTP_CODE)
    if httpCode != 200:
        print 'failed'
        return

    httpBody = buf.getvalue()
    httpBodyJson = json.loads(httpBody)
    print httpBodyJson


def main():
    ProductCommentUnitTest()


if __name__ == "__main__":
    main()


# doc: https://docs.python.org/2/library/unittest.html
