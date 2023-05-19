#!/usr/bin/env python3

import sys
import subprocess

def main():
    if len(sys.argv) < 2:
        print("expected an argument (build, debug, update-resources, encrypt, decrypt, update-site)")
        sys.exit()
    action = sys.argv[1]
    
    if action == "build":
        subprocess.run(["docker", "build", "-t", "ansible-terraform-demo", "."])

    if action == "debug":
        subprocess.run(["docker", "run", "-v", ".:/app", "-w", "/app/", "-it", "ansible-terraform-demo", "/bin/sh"])
    
    if action == "update-resources":
        subprocess.run(["docker", "run", "-v", ".:/app", "-w", "/app/", "-it", "ansible-terraform-demo", "/bin/sh", "scripts/update_resources.sh"])
    
    if action == "encrypt":
        subprocess.run(["docker", "run", "-v", ".:/app", "-w", "/app/", "-it", "ansible-terraform-demo", "/bin/sh", "scripts/encrypt.sh"])
    
    if action == "decrypt":
        subprocess.run(["docker", "run", "-v", ".:/app", "-w", "/app/", "-it", "ansible-terraform-demo", "/bin/sh", "scripts/decrypt.sh"])
    
    if action == "update-site":
         subprocess.run(["docker", "run", "-v", ".:/app", "-v", "/home/dylan/.ssh/:/root/.ssh/", "-w", "/app/", "-it", "ansible-terraform-demo", "/bin/sh", "scripts/update_site.sh"] + sys.argv[2:])


if __name__ == "__main__":
    main()