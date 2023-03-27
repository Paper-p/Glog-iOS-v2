
import RxFlow

enum GlogStep: Step {
    //Intro
    case introIsRequired
    
    //SignIn
    case signInIsRequired
    
    //SignUp
    case idIsRequired
    case pwdIsRequired
    case nickNameIsRequired
    
    //Main
    case mainIsRequired
    case detailIsRequired(model: PostList)
}
