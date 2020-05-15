//
//  Post.swift
//  Insta
//
//  Created by user169878 on 5/13/20.
//  Copyright © 2020 Algopedia. All rights reserved.
//

import Foundation

class Post{
    var caption: String
    var photoUrl: String
    
    init(captionText: String, photoUrlString: String)
    {
        caption = captionText
        photoUrl = photoUrlString
        
    }
}
