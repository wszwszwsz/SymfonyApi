Feature: Manage blog posts
    @createSchema
    Scenario: Create a blog post
        Given I am authenticated as "admin"
        When I add "Content-Type" header equal to "application/ld+json"
        And I add "Accept" header equal to "application/ld+json"
        And I send a "POST" request to "/api/blog_posts" with body:
    """
    {
      "title": "Hello a title",
      "content": "The content is suppose to be at least 20 characters",
      "slug": "a-new-slug"
    }
    """
        Then the response status code should be 201
        And the response should be in JSON
        And the JSON matches expected template:
    """
    {
      "@context": "/api/contexts/BlogPost",
      "@id": "@string@",
      "@type": "BlogPost",
      "comments": [],
      "id": @integer@,
      "title": "Hello a title",
      "content": "The content is suppose to be at least 20 characters",
      "slug": "a-new-slug",
      "published": "@string@.isDateTime()",
      "author": "/api/users/1",
      "images": []
    }
    """
    Scenario: Add comment to the new blog post
        Given I am authenticated as "admin"
        When I add "Content-Type" header equal to "application/ld+json"
        And I add "Accept" header equal to "application/ld+json"
        And I send a "POST" request to "/api/comments" with body:
    """
    {
      "content": "It's a first comment published to this post?",
      "blogPost": "/api/blog_posts/101"
    }
    """
        Then the response status code should be 201
        And the response should be in JSON
        And the JSON matches expected template:
    """
    {
      "@context": "/api/contexts/Comment",
      "@id": "@string@",
      "@type": "Comment",
      "id": @integer@,
      "content": "It\u0027s a first comment published to this post?",
      "published": "@string@.isDateTime()",
      "author": "/api/users/1",
      "blogPost": "/api/blog_posts/101"
    }
    """
    @createSchema
    Scenario: Throws an error when blog post is invalid
        Given I am authenticated as "admin"
        When I add "Content-Type" header equal to "application/ld+json"
        And I add "Accept" header equal to "application/ld+json"
        And I send a "POST" request to "/api/blog_posts" with body:
    """
    {
      "title": "",
      "content": "",
      "slug": "a-new-slug"
    }
    """
        Then the response status code should be 400
        And the response should be in JSON
        And the JSON matches expected template:
    """
    {
      "@context":"\/api\/contexts\/ConstraintViolationList",
      "@type":"ConstraintViolationList",
      "hydra:title":"An error  occurred",
      "hydra:description":"title: This value should not be blank.\ncontent: This value should not be blank.",
      "violations":[
        {
          "propertyPath":"title",
          "message":"This value should not be blank."
        },
        {
          "propertyPath":"content",
          "message":"This value should not be blank."
        }
      ]
    }
  """
    @createSchema
    Scenario: Throws an error when user is not authenticated
        When I add "Content-Type" header equal to "application/ld+json"
        And I add "Accept" header equal to "application/ld+json"
        And I send a "POST" request to "/api/blog_posts" with body:
    """
    {
      "title": "",
      "content": "",
      "slug": "a-new-slug"
    }
    """
        Then the response status code should be 401


