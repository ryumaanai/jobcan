require 'selenium-webdriver'
driver = Selenium::WebDriver.for :chrome

driver.get('https://id.jobcan.jp/users/sign_in?app_key=atd')
userEmail = driver.find_element(:id, 'user_email')
userEmail.send_keys '**********@**********'
userPass = driver.find_element(:id, 'user_password')
userPass.send_keys '**********'
driver.find_element(:class, 'form__login').click

driver.find_element(:id, 'adit-button-work-end').click
driver.quit