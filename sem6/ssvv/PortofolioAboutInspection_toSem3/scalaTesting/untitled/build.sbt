ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.12.10"

lazy val root = (project in file("."))
  .settings(
    name := "untitled"
  )

addCompilerPlugin("org.psywerx.hairyfotr" %% "linter" % "0.1.17")
