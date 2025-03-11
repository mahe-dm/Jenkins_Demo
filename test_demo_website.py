import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options

@pytest.fixture
def browser():
    options = Options()
    options.add_argument('--headless')
    service = Service('/usr/local/bin/geckodriver')
    driver = webdriver.Firefox(service=service, options=options)
    yield driver
    driver.quit()

def test_website_title(browser):
    url = "https://www.saucedemo.com/"
    browser.get(url)
    title = browser.title
    assert "Swag Labs" in title, "Title is incorrect"

def test_website_content(browser):
    url = "https://www.saucedemo.com/"
    browser.get(url)
    content = browser.find_element(By.ID, "login-button").get_attribute("value")
    assert "Login" in content, "Incorrect Content"

