    /* shows a list of all users in the CMS, their set file store quota and their current file size used */
    
    SELECT CMS_FILES_USERS.XYF_URLS.FULL_PATH, CMS_FILES_USERS.XYF_FILES.QUOTA, CMS_FILES_USERS.XYF_FILES.File_size
      FROM CMS_FILES_USERS.xyf_URLS, CMS_FILES_USERS.XYF_FILES 
     WHERE CMS_FILES_USERS.xyf_URLS.file_id=CMS_FILES_USERS.xyf_FILES.file_id
       AND FILE_TYPE_CODE = 'D'
       AND CMS_FILES_USERS.xyf_URLS.parent_id='1001'
   AND NOT CMS_FILES_USERS.XYF_FILES.File_size=0