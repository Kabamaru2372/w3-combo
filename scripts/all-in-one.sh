echo
echo "=============================="
echo " Inventory generated at: ansible/inventory.ini"
echo " Open these in your browser:"
if [[ "$MILESTONE" == "1" ]]; then
  SINGLE_IP=$(awk '/app1/{print $2}' inventory.ini | cut -d= -f2)
  echo "  http://${SINGLE_IP}"
elif [[ "$MILESTONE" == "2" ]]; then
  echo "  Apps:"
  grep '^app' inventory.ini | awk '{print "   - http://" $2}' | sed 's/ansible_host=//'
elif [[ "$MILESTONE" == "3" ]]; then
  LB_IP=$(awk '/lb1/{print $2}' inventory.ini | cut -d= -f2)
  echo "  LB: http://${LB_IP}"
  echo "  Apps:"
  grep '^app' inventory.ini | awk '{print "   - http://" $2}' | sed 's/ansible_host=//'
fi
echo "=============================="
echo
