Feature: Index a pair of sentences
  In order to index a pair of sentences
  As an indexer
  I want to receive a sentence object and index it.

Scenario: Index a Sentence instance
  Given I have a Sentence instance with '"Ate"와 "eight"는 동음이자이다.' and '"Ate" and "eight" are homophones.'
  When I need to index a instance
  Then I should see it in indices
