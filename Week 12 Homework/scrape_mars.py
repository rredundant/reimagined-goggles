import requests
from bs4 import BeautifulSoup
import pandas as pd
import re
import requests
from splinter import Browser

def scrape():
    # Pull first article title and blurb

    start = "https://mars.nasa.gov/api/v1/news_items/?page=0&per_page=40&order=publish_date+desc%2Ccreated_at+desc&search=&category=19%2C165%2C184%2C204&blank_scope=Latest"
    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}

    resp = requests.get(start, headers=headers).json()

    # If needed to determine what to pull, run next line:
    # resp['items'][0]

    art_title = resp['items'][0]['title']
    art_para = resp['items'][0]['description']

    # Could not get this to work.

    # executable_path = {'executable_path':"\\Users\\jarre\\chromedriver.exe"}
    # browser = Browser('chrome', **executable_path)

    # browser.visit('https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars')
    # button = browser.find_by_id('full_image')
    # button.click()

    # button = browser.find_by_text('more info')
    # button.click()

    # So instead, I went with Beautiful Soup

    url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'

    data = requests.get(url)
    soup = BeautifulSoup(data.content, "html.parser")

    # This targets the link.
    feat_pic = "https://www.jpl.nasa.gov" + soup.find('a', {'class': 'button fancybox'}).attrs.get('data-fancybox-href')

    # This makes sure it is the full-sized image.
    feat_pic = feat_pic.replace('medium', 'large')

    url = 'https://twitter.com/marswxreport?lang=en'

    weather = requests.get(url)
    soup = BeautifulSoup(weather.content, 'html.parser')

    weath_snip = soup.find('p', {'class': 'TweetTextSize TweetTextSize--normal js-tweet-text tweet-text'}).getText()

    # Get Facts
    url = 'https://space-facts.com/mars/'
    tables = pd.read_html(url)

    # Convert to DataFrame
    df = pd.DataFrame(tables[0])

    # Back to HTML
    html_table = df.to_html()
    html_table = html_table.replace('\n', '')

    url = "https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars"
    resp = requests.get(url)
    soup = BeautifulSoup(resp.content, "html.parser")

    # Create list of Hemisphere Names
    hemi_names = soup.findAll('h3')
    hemi_names = [str(x) for x in hemi_names]
    hemi_names = [t.replace('<h3>', '') for t in hemi_names]
    hemi_names = [t.replace(' Enhanced</h3>', '') for t in hemi_names]

    # Create list of Hemisphere urls
    link_partial = soup.findAll('a', {'class': 'itemLink product-item'})
    link_partial = [str(x) for x in link_partial]
    link_partial = [t.split("href=")[1] for t in link_partial]
    link_partial = [t.split("><img")[0] for t in link_partial]
    link_partial = [t.replace('"', '') for t in link_partial]
    link_partial = [t.split("/search/map")[1] for t in link_partial]
    link_full = ["http://astropedia.astrogeology.usgs.gov/download" + t + ".tif" for t in link_partial]

    # Combine
    hemispheres = []

    def hem_list(name, url):
        dict = {}
        for x in range(0,4):
            dictio = {'title': name[x], 'img_url': url[x]}
            hemispheres.append(dictio)
            
    hem_list(hemi_names, link_full)