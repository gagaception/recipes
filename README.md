# Recipes

This is a recipes application using Contentful Content Delivery API.
# Environment
```sh
ruby version '2.6.3'

rails version '6.0.3'
```

# Setting up

1. Get the source code from Github:
  ```sh
   git clone https://github.com/gagaception/recipes
   cd recipes
  ```
2. Install dependencies
  ```sh
   bundle install
  ```  
3. Add credentials 
  ```sh
  EDITOR=vim rails credentials:edit

  development:
    contentful:
      space_id: <SPACE_ID>
      access_token: <ACCESS_TOKEN>
  test:
    contentful:
      space_id: <SPACE_ID>
      access_token: <ACCESS_TOKEN>
  ```
4. Run app
  ```sh
  bundle exec bin/rails server
  ```