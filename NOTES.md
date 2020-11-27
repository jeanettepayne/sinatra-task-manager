Hi Jeanette! I'll keep this short:

I was able to link your css file to your `index.erb` file. From what I can tell, Sinatra is preconfigured to serve assets (like CSS or images) from a directory labeled `public`. Said public directory needs to live in the root directory of your application. (you can configure Sinatra to read assets from a different directory but thats another conversation for another time.)

My steps for connecting the `styles.css` file were as follows:
1. In terminal, from your applications root directory run:

```shell
mkdir public
```

2. The following command will create another directory named `stylesheets` in your public directory:
```shell
mkdir public/stylesheets
```

3. Move your `styles.css` file inside your `stylesheets` directory.

4. lastly, the css link tag in your index.erb file should look like this:
`<link rel="stylesheet" type="text/css" href="/stylesheet/styles.css">`

Hopefully that helps! Let me know if you have any questions.