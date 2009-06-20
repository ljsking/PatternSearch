Feature: Parse ptxt file
  In order to parse a ptxt file
  As an indexer
  I want to read ptxt files and make new ptxt objects.

Scenario: Read ptxt file
  Given I have a ptxt file named 0001.ptxt
  When I need to parse a file
  Then I should see a english sentences
  And I should see a korean sentences

