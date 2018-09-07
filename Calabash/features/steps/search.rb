Given(/^I on Search screen$/) do
end

When(/^I search "([^"]*)"$/) do |search|
  touch("searchBar")
  wait_for_keyboard
  keyboard_enter_text(search)
end

Then(/^I should see empty state note$/) do
  wait_for_element_exists("* marked:'No results'")
end

And(/^I tap on first result$/) do
  cell = query("* marked:'Search results' collectionViewCell").first
  touch(cell)
end

Then(/^Application should open detail of "([^"]*)" movie$/) do |movie|
  wait_for_element_exists("* marked:'Movie title' text:'#{movie}'")
end