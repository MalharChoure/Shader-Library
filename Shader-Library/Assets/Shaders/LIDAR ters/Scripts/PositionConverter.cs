using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PositionConverter : MonoBehaviour
{
    [SerializeField] private Transform obj;
    Renderer rend;
    // Start is called before the first frame update
    void Start()
    {
        rend=GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {
        rend.material.SetVector("_pos", obj.position);
    }
}
