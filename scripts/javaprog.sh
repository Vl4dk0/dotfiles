#!/usr/bin/env bash

if [[ -n $1 ]]; then
  mkdir -p "$1" && cd "$1" || exit 1
  echo "Created and moved into directory: $1"
fi

echo "" | gradle init --type basic --dsl kotlin 2>/dev/null
echo "Initialized Gradle project"

cat >build.gradle.kts <<'EOF'
plugins { id("java") }

repositories { mavenCentral() }

dependencies { testImplementation("junit:junit:4.13.2") }
EOF

echo "Configured build.gradle.kts"

mkdir -p src/main/java src/test/java

cat >src/main/java/Solution.java <<'EOF'
import java.util.*;
import java.io.*;

public class Solution {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
EOF

echo "Created src/main/java/Solution.java"
