from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from time import sleep

f = open('usa.txt')
word_list = f.read().splitlines()

driver = webdriver.Chrome(
    r'D:\College\SEM-3\DAA\AUTO COMPLETE PACKAGE\tree\chromedriver.exe')

driver.get('https://www.cs.usfca.edu/~galles/visualization/Trie.html')
sleep(5)
input_elt = driver.find_element_by_css_selector(
    '#AlgorithmSpecificControls > td:nth-child(1) > input[type=Text]')
input_btn = driver.find_element_by_css_selector(
    '#AlgorithmSpecificControls > td:nth-child(2) > input[type=Button]')
skip_btn = driver.find_element_by_css_selector(
    '#GeneralAnimationControls > td:nth-child(5) > input[type=Button]')

for i in range(100):
    input_elt.send_keys(word_list[i])
    #sleep(0.1)
    input_btn.click()
    #sleep(0.5)
    skip_btn.click()
    #sleep(0.5)