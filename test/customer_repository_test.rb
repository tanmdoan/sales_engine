require './test/test_helper'


class CustomerRepositoryTest < Minitest::Test
 attr_reader :customer_repository

 def setup
   @customer_repository = CustomerRepository.load(self, "./data/fixtures/customers_sample.csv")
 end

 def test_that_customer_repository_contains_customer_data
   assert 10 <= customer_repository.customers.count
 end

 def test_to_verify_that_customer_repository_is_not_empty
   refute customer_repository.customers.empty?
 end

 def test_it_can_find_by_customers_id
   results = customer_repository.find_by_id(1)
     assert_equal "1", results.id
 end

 def test_it_can_find_by_customers_first_name
   results = customer_repository.find_by_first_name("Joey")
      assert_equal "Joey", results.first_name
 end

 def test_it_can_find_by_customers_last_name
   results = customer_repository.find_by_last_name("Ondricka")
     assert_equal "Ondricka", results.last_name
 end

 def test_it_can_find_all_customers_by_first_name
   results = customer_repository.find_all_by_first_name("Joey")
   assert_equal 2, results.count
   results.each do |customer|
     assert_equal "Joey", customer.first_name
   end
 end

 def test_it_can_find_all_customers_by_last_name
   results = customer_repository.find_all_by_last_name("Ondricka")
   assert_equal 2, results.count
   results.each do |customer|
     assert_equal "Ondricka", customer.last_name
   end
 end

 def test_it_can_find_all_instances_of_customer
   customer_repo = CustomerRepository.load(self, './data/customers.csv')
   assert 100 <= customer_repo.customers.count
 end

 def test_it_can_pull_a_random_customers_instance
   results = customer_repository.random
   assert_equal 1, results.count
 end

end
