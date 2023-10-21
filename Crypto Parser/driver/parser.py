from selenium import webdriver
from selenium.webdriver.common.by import By
import pandas as pd

url = "https://coinmarketcap.com/currencies/aluna-social/holders/"


def parser(url):
    driver = webdriver.Chrome('/Users/kirill/Desktop/ppp/chromedriver')
    driver.get(url)
    data = driver.find_elements(by=By.TAG_NAME, value="td")
    a = []
    for item in data:
        a.append(item.text)
    address = a[1::5]
    aln = a[2::5]
    percent = a[3::5]
    return address, aln, percent


def builder():
    data = parser(url)
    df = pd.DataFrame({
        'Address': data[0],
        'ALN Amount': data[1],
        '% of Total Supply': data[2],
    })
    print(df)


if __name__ == "__main__":
    builder()
