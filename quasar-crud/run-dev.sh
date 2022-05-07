# https://stackoverflow.com/questions/3004811/how-do-you-run-multiple-programs-in-parallel-from-a-bash-script

json-server --watch backend/db.json &
P1=$!
cd frontend/ && quasar dev -- --host &
P2=$!
wait $P1 $P2