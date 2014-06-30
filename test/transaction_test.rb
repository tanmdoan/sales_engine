require './test/test_helper'
require './lib/transaction'

class TransactionTest<Minitest::Test

  def data
    {
      id: "5",
      invoice_id: "6",
      credit_card_number: "4654405418249632",
      credit_card_expiration_date: "",
      result: "success",
      created_at: "2014-06-06 14:12:12 UTC",
      updated_at: "2014-06-06 14:12:12 UTC"
    }
  end

  def test_it_has_a_id
    transaction = Transaction.new(data)
    assert_equal "5", transaction.id
  end

  def test_it_has_an_invoice_id
    transaction = Transaction.new(data)
    assert_equal "6", transaction.invoice_id
  end

  def test_it_has_a_credit_card_number
    transaction = Transaction.new(data)
    assert_equal "4654405418249632", transaction.credit_card_number
  end

  def test_it_has_a_bland_expiration_date
    transaction = Transaction.new(data)
    assert_equal "", transaction.credit_card_expiration_date
  end

  def test_is_has_a_result
    transaction = Transaction.new(data)
    assert_equal "success", transaction.result
  end

  def test_it_is_created_at
    transaction = Transaction.new(data)
    assert_equal "2014-06-06 14:12:12 UTC", transaction.created_at
  end

  def test_it_is_updated_at
    transaction = Transaction.new(data)
    assert_equal "2014-06-06 14:12:12 UTC", transaction.updated_at
  end
end
