require "date"
require 'selenium-webdriver'
driver = Selenium::WebDriver.for :chrome

driver.get('https://id.jobcan.jp/users/sign_in?app_key=atd')
userEmail = driver.find_element(:id, 'user_email')
userEmail.send_keys '**********@**********'
userPass = driver.find_element(:id, 'user_password')
userPass.send_keys '**********'
driver.find_element(:class, 'form__login').click

driver.find_element(:id, 'adit-button-work-start').click
nowTime = DateTime.now
nowHour = nowTime.hour
nowMinute = nowTime.minute
unless nowHour == 12 && nowMinute > 45 or nowHour == 9 && nowMinute > 45
  driver.navigate().to('https://ssl.jobcan.jp/employee/early-over-work/new')
  selectHour = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, 'start_h'))
  selectHour.select_by(:value, (nowHour - 5).to_s)
  selectMinute = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, 'start_m'))
  if nowMinute >= 45
    selectHour.select_by(:value, (nowHour - 4).to_s)
    selectMinute.select_by(:value, '0')
  elsif nowMinute >= 30
    selectMinute.select_by(:value, '45')
  elsif nowMinute >= 15
    selectMinute.select_by(:value, '30')
  else
    selectMinute.select_by(:value, '15')
  end
  reason = driver.find_element(:xpath, '//textarea')
  reason.send_key '勤務時間調整のため'
  driver.find_element(:class, 'btn-info').click
  driver.find_element(:class, 'btn-warning').click
  driver.quit
else
  driver.quit
end