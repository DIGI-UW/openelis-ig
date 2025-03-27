@ECHO OFF

# Build docker image tagged 'openelis-ig-publisher'
docker build -t openelis-ig-publisher .

# Run docker container mounting the current directory as /app, passing any arguments
docker run --rm -v "%CD%/output":/ig/output openelis-ig-publisher "%*"
