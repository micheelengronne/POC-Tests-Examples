# EXO1

## Kube runtime

L'équipe de Kubernetes a annoncé l'abandon de Docker.

L'exercice consiste à remplacer le runtime de Kubernetes par CRI-O ou containerd ou runc (le mieux est CRI-O).

Il faut le faire sans mettre un doigt dans la prod, donc par un role ou une collection ansible.

En bonus, en CI, on teste ce changement en utilisant Inspec.

## Container sans Dockerfile

Construire un role ansible qui permette de build un container sans Dockerfile.

C'est l'éxécution du role ansible qui construit le container.

En bonus, en CI, on teste ce role et le container résultant avec molecule et Inspec.
