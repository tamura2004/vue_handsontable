package main

import (
	"log"
	"io/ioutil"
	"os/exec"
	"time"
)

func main() {
	filename := time.Now().Format("../tmp/20060102backup.sql")
	out, err := exec.Command("pg_dump", "--inserts", "-a" , "--exclude-table-data=schema_migrations","projects_members_development").Output()

	if err != nil {
		log.Fatal(out,err)
	}

	err = ioutil.WriteFile(filename, out, 0666)

	if err != nil {
		log.Fatal(err)
	}

}
