# tf-live

### How to use
1. Create VPC
2. Create Network
3. Create Shared Key Pair
4. Create Tailscale (requires Tailscale Auth Key)
   1. Disable Key Expiry on Tailscale
   2. Approve subnets 
5. Create Admin Launch Template
6. Create Admin Launch Instance
7. Connect to Admin instance
   1. Create a new folder in C Drive called "SharedDrive"
   2. Right click on SharedDrive, select properties
   3. Go to share settings, click on share. 
   4. Add "All Users" with read/write permissions
   5. Save
   6. Go to my computer, click on computer on the top
   7. Click on "Map network drive"
   8. Enter the following "\\${IP_ADDR}\SharedDrive"
   9. Save
8. Create User Launch Template
9. Create User instance (1)
10. Connect to User instance
    1. Go to my computer, click on computer on the top
    2. Enter the shared drive address from above (step 6.8)
    3. Save
11. Create User Launch Template from Snapshot
12. Create User Instances Replica
13. Success 🚀
