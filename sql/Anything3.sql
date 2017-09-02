CREATE TABLE nodes (
    node_id		UNSIGNED INTEGER NOT NULL AUTO_INCREMENT,
    title		VARCHAR(255),
    author_id		UNSIGNED INTEGER NOT NULL,
    history_nonce	UNSIGNED INTEGER NOT NULL,
    dtstamp		DATETIME NOT NULL,
    type		INTEGER NOT NULL,
    content		TEXT
);

/* type:
0	Hidden/deleted
1	Wiki post
2	Wiki talk
3	Blog post
4	Blog reply -- history_nonce is really parent_id.
*/

CREATE TABLE history (
    entry_id		UNSIGNED INTEGER NOT NULL AUTO_INCREMENT,
    history_id		UNSIGNED INTEGER NOT NULL,
    node_id		UNSIGNED INTEGER NOT NULL
);

CREATE TABLE users (
    user_id		UNSIGNED INTEGER NOT NULL AUTO_INCREMENT,
    status		INTEGER NOT NULL,
    name		VARCHAR(255) NOT NULL,
    fullname		VARCHAR(255) NOT NULL,
    email		VARCHAR(255) NOT NULL,
    salt		BINARY(64) NOT NULL,
    pass_hash		VARCHAR(255) NOT NULL,
    reset_nonce		VARCHAR(255),
    reset_dtstamp	DATETIME,
    user_node_id	UNSIGNED INTEGER NOT NULL
);

/* status:
-3	Banned
-2 	Pay to play
-1 	Read only
0  	Disabled
1	Unverified (reset_nonce is verification code)
2	User
3	Admin

if reset_nonce IS NOT NULL and reset_dtstamp is not too old,
    reset_nonce is valid for changing passwords.
*/

CREATE TABLE login_attempts (
    la_id		UNSIGNED INTEGER NOT NULL AUTO_INCREMENT,
    user_id		UNSIGNED INTEGER NOT NULL,
    session_nonce	UNSIGNED INTEGER,  -- null=failed login
    attempt_time	DATETIME NOT NULL
);


CREATE TABLE banlines (
    ban_id		UNSIGNED INTEGER NOT NULL AUTO_INCREMENT,
    type		UNSIGNED INTEGER NOT NULL,
    penalty		UNSIGNED INTEGER NOT NULL,
    value		VARCHAR(4096),
    dtstamp		DATETIME
);

/* banlines.type:
0	disabled
1	username
2	email
3	domain
4	ip address
5	ip range

banlines.penalty bitfield:
1	timed/perament
2	if set, can pay to unlock
3	clear=read only; set=full ban5
*/

CREATE TABLE tags (
    tag_id		UNSIGNED INTEGER NOT NULL AUTO_INCREMENT,
    name		VARCHAR(255)
);

CREATE TABLE tag_nodes (
    tag_node_id		UNSIGNED INTEGER NOT NULL AUTO_INCREMENT,
    tag_id		UNSIGNED INTEGER,
    node_id		UNSIGNED INTEGER
);
