# WORDPRESS - CHANGE URL IN DATABASE

## USE MYSQL TO RUN THESE COMMANDS

<br>
<hr>

```

UPDATE wp_options SET option_value = replace(option_value, 'oldurl.com', 'newurl.com') WHERE option_name = 'home' OR option_name = 'siteurl';
UPDATE wp_posts SET guid = replace(guid, 'oldurl.com','newurl.com');UPDATE wp_posts SET post_content = replace(post_content, 'oldurl.com', 'newurl.com');
UPDATE wp_postmeta SET meta_value = replace(meta_value,'oldurl.com','newurl.com');

```

## NOTE:  change the wp_ to your database’s value
