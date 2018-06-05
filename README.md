# 7330project-OSF Database
***************************
Requirements (all completed):
*Our Software Factory develops various software products, each one requiring a software build. 
*A software product is identified by its name and version.  
*A software build identifies the components needed for a particular product. 
*Components may be shared among products. 
*The build status for a product is the lowest status of any of its components. 
*Each component has a status of ready, usable, and not-ready. 
*Information required about each component includes size, programming language (C, C++, C#, Java, or PHP), component name and 3 character version. 
*Each component has one person identified as its owner. People have a unique ID (5 digit number), name (60 characters) and seniority. *Components get their status as a result of a software inspection (peer review). 
*An inspection event covers one component and results in an inspection score (0 .. 100). 
*If the score is greater than 90, the component is considered “Ready”.  If the score is less than 75, it is “not-ready”; otherwise it is “usable”. 
*Inspection data includes what was inspected, the date of inspection, who conducted the inspection, inspection score, and textual description. 
*The textual description can be updated later, but the score can never be changed.  
*Components may be inspected multiple times.
