<script>
net user administrator ${admin_password} 
netdom.exe renamecomputer %computername% /newname:${host_name} /force /REboot 1
</script>
