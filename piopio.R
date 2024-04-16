
# Librerías ---------------------------------------------------------------

require(RSelenium)
require(rvest)

# Inicio de servidor y sesión en twitter ----------------------------------

# usethis::edit_r_environ()
# ó
# Sys.setenv(USER = "@xxxxxxxxxxx")
# Sys.setenv(PASS = "xxxxxxxxxxxx")

url <- "https://twitter.com/i/flow/login"

servidor <- rsDriver(browser = "firefox", port = 2345L, chromever = "108.0.5359.22")
cliente <- servidor$client             
cliente$navigate(url) 

Sys.sleep(5)

input_1 <- "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div/div/div/div[5]/label/div/div[2]/div/input"
input_2 <- "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[1]/div/div/div[3]/div/label/div/div[2]/div[1]/input"
clic__1 <- "/html/body/div[1]/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div/div/div/div[6]/div"
imput_3 <- "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[1]/div/div[2]/label/div/div[2]/div/input"
iniciar <- "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[2]/div/div[1]/div/div/div/div"

username <- cliente$findElement(using = "xpath", input_1)
username$sendKeysToElement(list(Sys.getenv("USER")))

clic <- cliente$findElement(using = "xpath", value = clic__1)
clic$clickElement() 

Sys.sleep(5)

passwd <- cliente$findElement(using = "xpath", value = input_2)
passwd$sendKeysToElement(list(Sys.getenv("PASS")))

iniciar_sesion <- cliente$findElement(using = "xpath", iniciar)
iniciar_sesion$clickElement() 


# Para hacer scroll -------------------------------------------------------

down_arrow_plus <- list(key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow", 
                    key = "down_arrow", key = "down_arrow")

# Código para perfiles de usuarixs ----------------------------------------

usuarix <- "div.css-175oi2r div.css-1rynq56.r-8akbws.r-krxsd3.r-dnmrzs.r-1udh08x.r-bcqeeo.r-qvutc0.r-37j5jr.r-a023e6.r-rjixqe.r-16dba41.r-bnwqim"

cliente$navigate("https://twitter.com/RioNegroSalud") 

Sys.sleep(5)

tweets_R <- c()
down_arrow <- list()

for (i in 1:20) {
  X <- cliente$getPageSource()[[1]]
  X_html <- read_html(X)
  tweets_R <- append(tweets_R, 
                     html_text2(html_elements(
                       X_html, css = usuarix)))
  down_arrow <- append(down_arrow, down_arrow_plus)
  scroll <- cliente$findElement("css", "body")
  scroll$sendKeysToElement(down_arrow)
  message("Iteración: ", i)
  Sys.sleep(1.5)
}

(tweets_R <- unique(tweets_R))


# Código para tendencias --------------------------------------------------

hashtag <- "section:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div > div:nth-child(1) > div:nth-child(1) > article:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(2)"
user <- "/html/body/div/div/div/div/main/div/div/div/div/div/div/section/div/div/div/div/div/article/div/div/div[2]/div[2]/div[1]/div/div[1]/div/div/div[2]/div/div[1]"

cliente$navigate("https://twitter.com/search?q=%22DNU%20de%20Javier%20Milei%22&src=trend_click&vertical=trends") 

Sys.sleep(5)

tweets <- c()
users <- c()

down_arrow <- list()

for (i in 1:20) {
  X <- cliente$getPageSource()[[1]]
  X_html <- read_html(X)
  tweets <- append(tweets, 
                     html_text2(html_elements(
                       X_html, css = hashtag)))
  
  users <- append(users, 
                   html_text2(html_elements(
                     X_html, xpath = user)))
  
  down_arrow <- append(down_arrow, down_arrow_plus)
  scroll <- cliente$findElement("css", "body")
  scroll$sendKeysToElement(down_arrow)
  message("Iteración: ", i)
  Sys.sleep(1.5)
}

tweets_df <- tibble::tibble(
  usuarix = users,
  tweet = tweets
)

(tweets_df <- unique(tweets_df))


# Código para resultados de búsquedas ----------------------------------------

usuarix <- "div.css-175oi2r div.css-1rynq56.r-8akbws.r-krxsd3.r-dnmrzs.r-1udh08x.r-bcqeeo.r-qvutc0.r-37j5jr.r-a023e6.r-rjixqe.r-16dba41.r-bnwqim"

cliente$navigate("https://twitter.com/search?q=dengue") 

Sys.sleep(5)

tweets_r <- c()
down_arrow <- list()

for (i in 1:20) {
  X <- cliente$getPageSource()[[1]]
  X_html <- read_html(X)
  tweets_r <- append(tweets_r, 
                     html_text2(html_elements(
                       X_html, css = usuarix)))
  down_arrow <- append(down_arrow, down_arrow_plus)
  scroll <- cliente$findElement("css", "body")
  scroll$sendKeysToElement(down_arrow)
  message("Iteración: ", i)
  Sys.sleep(1.5)
}

(tweets_r <- unique(tweets_r))


# Código para cerrar servidor ----------------------------------------

cliente$close()
servidor$server$stop()
