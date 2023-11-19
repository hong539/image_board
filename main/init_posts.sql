--
-- Create model Post
--
CREATE TABLE `posts_post` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `subject` varchar(200) NOT NULL, `content` longtext NOT NULL, `created_date` datetime(6) NOT NULL, `user_id` integer NOT NULL);
--
-- Create model Comment
--
CREATE TABLE `posts_comment` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `content` longtext NOT NULL, `created_date` datetime(6) NOT NULL, `post_id` bigint NOT NULL, `user_id` integer NOT NULL);
ALTER TABLE `posts_post` ADD CONSTRAINT `posts_post_user_id_a4f40dc7_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
ALTER TABLE `posts_comment` ADD CONSTRAINT `posts_comment_post_id_e81436d7_fk_posts_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts_post` (`id`);
ALTER TABLE `posts_comment` ADD CONSTRAINT `posts_comment_user_id_ad949c47_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
