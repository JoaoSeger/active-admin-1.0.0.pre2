Feature: Index as Blog

  Viewing resdources as a blog on the index page

  Scenario: Viewing the blog with a resource
    Given a configuration of:
      """
      ActiveAdmin.register Post do
        index :as => :blog
      end
      """
	And I am logged in
    And a post with the title "Hello World" exists
    When I am on the index page for posts
    Then I should see /Post \d+/ within "h3"
    And I should see a link to /Post \d+/

  Scenario: Viewing the blog with a resource as a simple configuration
    Given a configuration of:
      """
      ActiveAdmin.register Post do
        index :as => :blog do |i|
          i.title :title
          i.content :body
        end
      end
      """
	And I am logged in
    And a post with the title "Hello World" and body "My great post body" exists
    When I am on the index page for posts
    Then I should see "Hello World" within "h3"
    And I should see a link to "Hello World"
    And I should see "My great post body" within ".post"

  Scenario: Viewing the blog with a resource as a block configuration
    Given a configuration of:
      """
      ActiveAdmin.register Post do
        index :as => :blog do |i|
          i.title {|post| post.title + " From Block" }
          i.content {|post| post.body + " From Block" }
        end
      end
      """
	And I am logged in
    And a post with the title "Hello World" and body "My great post body" exists
    When I am on the index page for posts
    Then I should see "Hello World From Block" within "h3"
    And I should see a link to "Hello World From Block"
    And I should see "My great post body From Block" within ".post"
