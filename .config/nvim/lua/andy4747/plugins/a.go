package main

import "errors"

func returnsError() error { return errors.New("test") }
func main()               { returnsError() } // Should trigger diagnostic
