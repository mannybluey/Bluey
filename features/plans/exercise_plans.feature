Feature: Manage exercise plans
  In order to allow users to manage their exercise regime
  A user
  Should be able to manage their exercise plans

    Background:
      Given I am a new, authenticated user
      And I have the following exercise records:
        | name        |
        | Bench press |
        | Sit-ups     |
        | Hello world |

    Scenario: View list of existing plans
      Given I have the following users:
        | name         | email         | password   |
        | Alex         | alex@test.com | mypassword |
      And I have the following plans created by Alex:
        | name         | day | exercises            |
        | Alex's plan  | 1   | Bench press, Sit-ups |
        |              | 2   | Sit-ups              |
      When I follow "Plans" within "nav"
      Then show me the page
      Then I should see the following list of plans:
        | creator | name        |
        | Alex    | Alex's plan |

    @javascript
    Scenario: View an existing plan
      Given I have the following plan records:
        | name    |
        | My plan |
      And I follow "Plans" within "nav"
      And I follow "My plan"
      Then I should see "Bench press"

    @javascript
    Scenario: Creating a plan with some items but without a name
      Given I follow "Plans" within "nav"
      And I follow "Create a plan"
      And I fill in "Description" with "My description"
      When I add the following days to the plan:
        | day   | exercises            |
        | 1     | Bench press, Sit-ups |
        | 2     | Bench press          |
      And I press "Create"
      Then I should see "Name can't be blank"
      And I should see the following days in the plan:
        | day   | exercises            |
        | 1     | Bench press, Sit-ups |
        | 2     | Bench press          |

    @javascript
    Scenario: Creating a plan with a single day and some items
      Given I follow "Plans" within "nav"
      And I follow "Create a plan"
      When I fill in "Name" with "My plan"
      And I fill in "Description" with "My description"
      When I add the following days to the plan:
        | day   | exercises            |
        | 1     | Bench press, Sit-ups |
        | 2     | Bench press          |
        | 3     | Hello world          |
      When I press "Create"
      Then I should see "Successfully created plan"
      And I should see "My plan"
      Then I should see the following days in the plan:
        | day   | exercises            |
        | 1     | Bench press, Sit-ups |
        | 2     | Bench press          |
        | 3     | Hello world          |
