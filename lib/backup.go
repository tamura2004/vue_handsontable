package main

import (
	"log"
	"io/ioutil"
	"os/exec"
	"time"
)

func main() {
	filename := time.Now().Format("../tmp/20060102backup.sql")
	out, err := exec.Command(
		"pg_dump",
		"-U".
		"tamura"
		"--inserts",
		"-a" ,
		"--data-only",
		"--exclude-table-data=schema_migrations",
		"--exclude-table-data=ar_internal_metadata",
		"prod_work"
	).Output()
	handleErr(err)

	err = ioutil.WriteFile(filename, out, 0666)
	handleErr(err)
}

func handleErr(err error){
	if err != nil {
		log.Fatal(err)
	}
}
