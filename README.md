# Project Planetarium 

## update Jan 19, 2023
- added dashboard
- fixed ingress rule
- incorporated Terraform-created RDS into the planetarium project
- all discovered issues fixed

## update Jan 18, 2023
- finished Terraform bucket and RDS creation
- things left:
    - link the created RDS with K8s
    - add Grafana custom alerts and dashboards 
- issues discovered:
    - Terraform keeps giving a invalid credential error
        - solved: update C://Users/user/.aws/credentials file and add IAM credentials
    - Terraform gives a invalid DB engine error
        - solved: Use Postgres instead of PostgreSQL. Don't be mislead by the engine name on AWS
- issue pending:
    - URI with /planetarium added will bypass the authentication step

## update Jan 17. 2023
- GOOD NEWS: issues auto-fixed:
    - pending prometheus external node auto replaced
    - prometheus data source successfullly added
    - jenkins pipeline successfully built without error messages
- issue with logging: localhost8080 generates log but cluster url does not
    - solved: updated webmvcconfig file and added /planetarium in the URI
        - Collections can be run smoothly
        - Cluster error logs (400) are not pushed to local logs but can be detected by Loki

## update Jan 16, 2023
- added minor details to the source code
    - added DataIntegrityViolationException exception handler to prevent registering duplicate users
    - made id a mandatory entry when creating moon/planet to ensure better workflow
    - added "api" before moon and planet related URIs
    - updated pom.xml and renamed mvn package as "project2"
- tested source code with thunder client
    - everything has passed with 200 and 201 except REGISTER: expect a 400/404 because we cannot register two users with the same username
- docker image recreated and uploaded to the group account
- discovered questions to be answered...
    - when doing "docker compose up -d", a Network project_2_default is being created... what is this?
    - one prometheus-external-node is pending...
    - prometheus data source not found on grafana. when manually adding, "Error reading Prometheus: An error occurred within the plugin"
    - solved: uninstalling helm charts resulted in indefinite "Terminating" status on select pods
        - force delete the pod by using {kubectl delete pod <PODNAME> --grace-period=0 --force --namespace <NAMESPACE>}
        - RETRO REVIEW FROM JAN 17, 2023: FORCE DELETE WILL ONLY DELETE THE POD FROM CLI, NOT ACTUALLY STOPPING/TERMINATING IT FROM THE CLUSTER. THE POD MIGHT STILL BE RUNNING IN THE BACKEND--THIS WILL CAUSE ISSUES EVERYWHERE DOWN THE STREAM
            - WHEN REINSTALLING HELM CHARTS AND RECONFIGURING YAML FILES A POD WILL BE IN PENDING STATUS UNTIL THE INVISIBLE POD IS ACTUALLY TERMINTED
            - WHEN ACCESSING GRAFANA, ONLY LOKI SHOWS UP AS A DATA SOURCE, NO PROMETHEUS
                - WHEN TRYING TO ADD PROMETHEUS, A "Error reading Prometheus: An error occurred within the plugin" MESSAGE WILL POP UP
            - WHEN ACCESSING JENKINS, TWO DIFFERENT ERROR MESSAGES SHOW UP:
                - "error looking up service account default/jenkins: serviceaccount "jenkins" not found."
                - "jenkins Startup probe failed: HTTP probe failed with statuscode: 503"

## update Jan 13, 2023
- refurnished Spring app 
- recreated docker image named rollingNew. :latest and :rolling temporarily not in use
- fixed issues with adding custom dashboards to Grafana: New->Import->JSON file
- fixed issues with github webhook setup with status code 302: the webhook url should end with "/"
- configured Jenkins
- discovered issue with logging: localhost8080 generates log but cluster url does not
    - will set up other infrastructures and come back if needed

## update Jan 12, 2023
- added imaged for static and rolling logs
- fixed issues with pods restarting by updating security groups for RDS
- fixed issues with "promtail-config not found": need to kubectl apply -f promtail-configuration first
- discovered issues with Grafana: Loki data source not set up by default
    - temp solution: add manually, data source and label found successfully