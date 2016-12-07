### Extract info online (web-scrapping)
library(rvest)
library(stringr)

#list of recount_url
source("./code/1-preprocess.R")
recount_url= paste0("http://www.jhsph.edu/courses/course/22150/2015/",course_all,"/")
htmlfile = read_html(recount_url[10])
course_info=data.frame(course_id=character(), 
                       course_name=character(),
                       time=character(),
                       term=character(),
                       instructor=character())

#recount_url ="http://www.jhsph.edu/courses/course/22150/2015/700.603.01/"



nds_daytime = html_nodes(htmlfile,xpath = '//*[@id="modCourseSearch"]/div[2]/div[1]/dl/dd[6]/ul/li
')
nds_term=html_nodes(htmlfile,xpath='//*[@id="modCourseSearch"]/div[2]/div[1]/dl/dd[2]')
nds_instructor=html_nodes(htmlfile,xpath='//*[@id="modCourseSearch"]/div[2]/div[2]/dl/dd[4]/ul')
nds_course=html_nodes(htmlfile,xpath = '//*[@id="modCourseSearch"]/h1')


info <- function(htmlfile){
    
    ## Extract nodes from html file: daytime, term, instructor, coursename
    nds_daytime = html_nodes(htmlfile,xpath = '//*[@id="modCourseSearch"]/div[2]/div[1]/dl/dd[6]/ul/li
')
    nds_term=html_nodes(htmlfile,xpath='//*[@id="modCourseSearch"]/div[2]/div[1]/dl/dd[2]')
    nds_instructor=html_nodes(htmlfile,xpath='//*[@id="modCourseSearch"]/div[2]/div[2]/dl/dd[4]/ul')
    nds_course=html_nodes(htmlfile,xpath = '//*[@id="modCourseSearch"]/h1')
    #nds_credit=html_nodes(htmlfile,xpath = '')
    
    ## Extract contents
    time = html_text(nds_daytime) %>% str_replace_all(pattern="\n",replacement="") %>%
        str_replace_all(pattern="\t",replacement="") %>%
        str_replace_all(pattern=" ",replacement="")
    
    term=gsub(" term","",html_text(nds_term))
    
    instructor= html_text(nds_instructor) %>% 
        str_replace_all(pattern="\t",replacement="") %>% 
        str_extract_all(pattern="[a-zA-Z].*") %>% unlist()
    
    course_id= gsub(" .*","",html_text(nds_course))
    course_name= html_text(nds_course) %>% str_replace_all(pattern="[0-9]",replacement="") %>%
        str_replace_all(pattern="\\.",replacement="") %>% str_trim(side="left")
    
    
}




for(i in 1:10){
    htmlfile = read_html(recount_url[i])
    
}
