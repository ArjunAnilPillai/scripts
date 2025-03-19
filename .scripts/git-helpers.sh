# force_push                                                                                                                                                                                    
# CAUTION: This is a dangerous operation.                                                                                                                                                       
function force_push() {                                                                                                                                                                         
    echo -e "force_push $1\n---\n\$ git push --force $1"                                                                                                                                        
    git push --force origin $1                                                                                                                                                                  
    echo "---"                                                                                                                                                                                  
}                                                                                                                                                                                               
export -f force_push

# git_push                                                                                                                                                                                      
function git_push() {                                                                                                                                                                           
        echo -e "git_push $1\n---\n\$ git push origin $1"                                                                                                                                       
        git push origin $1                                                                                                                                                                      
        echo "---"                                                                                                                                                                              
}                                                                                                                                                                                               
export -f git_push

# rebase_master                                                                                                                                                                                 
function rebase_master() {                                                                                                                                                                      
    echo -e "rebase_master $1 $2\n---\n\$ git checkout master"                                                                                                                                  
    git checkout master                                                                                                                                                                         
    echo -e "---\n\$ git pull"                                                                                                                                                                  
    git pull                                                                                                                                                                                    
    echo -e "---\n\$ git checkout $1"                                                                                                                                                           
    git checkout $1                                                                                                                                                                             
    echo -e "---\n\$ git rebase $2 master"                                                                                                                                                      
    git rebase $2 master                                                                                                                                                                        
    echo "---"                                                                                                                                                                                  
}                                                                                                                                                                                               
export -f rebase_master                                                                                                                                                                         
                                                                                                                                                                                                
# rebase_and_force_push                                                                                                                                                                         
# CAUTION: This is a dangerous operation.                                                                                                                                                       
function rebase_and_force_push() {                                                                                                                                                              
    rebase_master $1 $2                                                                                                                                                                         
    force_push $1                                                                                                                                                                               
}                                                                                                                                                                                               
export -f rebase_and_force_push                                                                                                                                                                 
                                                                                                                                                                                                
# rebase_and_push                                                                                                                                                                               
function rebase_and_push() {                                                                                                                                                                    
        rebase_master $1 $2                                                                                                                                                                     
        git_push $1                                                                                                                                                                             
}                                                                                                                                                                                               
export -f rebase_and_push