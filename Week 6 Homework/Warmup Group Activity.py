
# coding: utf-8

# In[9]:

import requests
import pandas as pd
import re

import geopy.distance # pip install geopy, or conda install geopy

# reminder how to use geopy to compute kilometers


coords_1 = (52.2296756, 21.0122287)
coords_2 = (52.406374, 16.9251681)
print(geopy.distance.distance(coords_1, coords_2).km)


# In[35]:

# These are places in the united states
# Find the 2 places that are closest to one another
# Find the 2 places that are furthest away

from itertools import combinations # Hint, use combinations to generate all pairs of 2 coordinates

# Maybe store the pairs in a dictionary, where the value at the key[(p1, p2)] = distance_between_them
# Alternatively, you could store them in a list of dictionaries, where there's a key for place1 and place2
# .  then use pandas?

# if you get that, figure out the shortest path that you can possibly take to visit all the locations and end up
# back at the place you began :) 


pairs = [
    
    (40.7128, -74.0060),
    (39.7392, -104.9903),
    (37.2982, -113.0263),
    (32.2226, -110.9747),
    (39.0997,  -94.5786)
    
]

# Example of generating combos of length 2 with a bunch of names
# Try to generalize it to the pairs of coordinates

names = ['jeff', 'chance', 'scouty', 'michelle', 'mike']

data = []
for row in combinations(zip(names,pairs), 2):
    data.append(row)


# In[38]:

# nested loop on the same thing
for p1 in pairs:
    for p2 in pairs:
        if p1 != p2:
            print(p1, p2)


# In[ ]:




# In[16]:

data = pd.DataFrame(data)


# In[21]:

data.head()


# In[22]:

data.columns = ['one','two']


# In[27]:

data = pd.concat([data['one'].apply(pd.Series),data['two'].apply(pd.Series)], axis=1)


# In[28]:

data.columns = ['Name','Coord_1','Name_2','Coord_2']


# In[30]:

def map_dist(row):
    return (geopy.distance.distance(row.Coord_1, row.Coord_2).km)


# In[32]:

data['distance'] = data.apply(map_dist,axis=1)


# In[34]:

data['distance'].describe()


# In[53]:

def get_weather_from_coords(row):
    # row is just a row from a dataframe, I can access cols like row.colName or row['ColName']
    key = '0bbf7572880155f0d500eca39a583571'
    api = 'https://api.openweathermap.org/data/2.5/weather?lat={}&lon={}&appid={}&units=imperial'.format(row['CapitalLatitude'], row['CapitalLongitude'], key)
    resp = requests.get(api).json() # I want a dictionary
    return resp

df = pd.read_json('http://techslides.com/demos/country-capitals.json')
df = df.sample(n=5)
df['weather_result'] = df.apply(get_weather_from_coords, axis=1)
df.head()

# grab 10 random rows, get the watheer

# https://api.openweathermap.org/data/2.5/weather?lat=35.3&lon=139.09&appid=0bbf7572880155f0d500eca39a583571&units=imperial


# In[54]:

df['temp'] = df['weather_result'].map(lambda x: x.get('main').get('temp'))
df.head()


# In[57]:

for index, row in df.iterrows():
    print(index, row.temp)
    print()


# In[ ]:

# Bonus - pick a capital city, find the capital city that's closest to it, based on their respective lat longs


# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:



