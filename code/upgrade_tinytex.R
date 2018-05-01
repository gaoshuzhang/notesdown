
library(tinytex)

upgrade_tinytex <- function(repos = NULL) {
  # 此处还要考虑用户输错的情况和选择离用户最近（快）的站点
  if(is.null(repos)) repos = "https://mirrors.tuna.tsinghua.edu.cn/CTAN/"
  
  file_ext <- if (.Platform$OS.type == "windows") ".exe" else ".sh"
  tlmgr_url <- paste(repos, "/systems/texlive/tlnet/update-tlmgr-latest", file_ext, sep = "")
  file_name <- paste0("update-tlmgr-latest", file_ext)
  download.file(url = tlmgr_url, destfile = file_name, 
                mode = if (.Platform$OS.type == "windows") "wb" else "w")
  
  # window下 命令行窗口下 如何执行 exe 文件
  if(.Platform$OS.type == "windows"){
    shell.exec(file = file_name)
    file.remove("update-tlmgr-latest.exe")
  }
  else{
    system("sudo sh update-tlmgr-latest.sh  -- --upgrade")
    
    file.remove("update-tlmgr-latest.sh")
  }
  
  # 类似地 Linux 下执行 sh
  # 升级完了 删除 update-tlmgr-latest.exe
}



