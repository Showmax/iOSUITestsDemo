Given("I on Search screen") do
end

When("I search {string}") do |search|
    $driver.find_element(:class, 'XCUIElementTypeSearchField').send_keys(search)
end

Then("I should see empty state note") do
    $driver.find_element(:accessibility_id, "No results")
end

And("I tap on first result") do
    $driver.find_element(:accessibility_id, "Search results").find_element(:class, 'XCUIElementTypeCell').click
end

Then("Application should open detail of {string} movie") do |movie|
    expect($driver.find_element(:accessibility_id, "Movie title").text).to eq movie
end